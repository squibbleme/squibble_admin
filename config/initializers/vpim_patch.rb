# -*- encoding : utf-8 -*-
=begin
  Copyright (C) 2008 Sam Roberts
  This library is free software; you can redistribute it and/or modify it
  under the same terms as the ruby language itself, see the file COPYING for
  details.
=end


# Monkey Patch: cle@2016-06-08
# Github: https://github.com/sam-github/vpim/pull/20/commits/6ec74edc131d70ac2711709bc34c9617356e368e
#
require 'vpim/vpim'

module Vpim

  # param-value = paramtext / quoted-string
  # paramtext  = *SAFE-CHAR
  # quoted-string      = DQUOTE *QSAFE-CHAR DQUOTE
  def Vpim.encode_paramtext(value)
    case value
    when %r{\A#{Bnf::SAFECHAR}*\z}n
      value
    else
      raise Vpim::Unencodeable, "paramtext #{value.inspect}"
    end
  end

  def Vpim.encode_paramvalue(value)
    case value
    when %r{\A#{Bnf::SAFECHAR}*\z}n
      value
    when %r{\A#{Bnf::QSAFECHAR}*\z}n
      # Überarbeitung MonkeyPatch: value ohne "-Zeichen
      #
      value
    else
      raise Vpim::Unencodeable, "param-value #{value.inspect}"
    end
  end

end
