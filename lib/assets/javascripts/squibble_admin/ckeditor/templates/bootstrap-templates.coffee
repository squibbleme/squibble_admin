CKEDITOR.addTemplates "bootstrap",
  # The name of the subfolder that contains the preview images of the templates.
  imagesPath: CKEDITOR.getUrl(CKEDITOR.plugins.getPath("templates") + "templates/images/")

  # Template definitions.
  templates: [
    title: "Section + Container + 1"
    description: "Klassischer Vollbild Wrapper inkl. einer Spalte"
    html: '''
      <section>
        <div class="container">
          <div class="row">
            <div class="col-md-12">
              <h1>Hier kommt eine Überschrift</h1>
              <p>
                Hier kommt der entsprechende Inhalt zu dieser eben erwähnten Überschrift
              </p>
            </div>
          </div>
        </div>
      </section>
    '''
  ,
    title: "Section + Container + 2:1"
    description: "Klassischer Vollbild Wrapper inkl. zwei Spalten"
    html: '''
      <section>
        <div class="container">
          <div class="row">
            <div class="col-md-12">
              <h1>Hier kommt eine Überschrift</h1>
            </div>
            <div class="col-md-4">
              <h3>Hier kommt eine Überschrift</h3>
              <p>
                <img src="http://placehold.it/640x480" class="img-responsive" />
              </p>
              <p>
                Hier kommt der entsprechende Inhalt zu dieser eben erwähnten Überschrift
              </p>
            </div>
            <div class="col-md-8">
              <h3>Hier kommt eine Überschrift</h3>
              <p>
                Hier kommt der entsprechende Inhalt zu dieser eben erwähnten Überschrift
              </p>
            </div>
          </div>
        </div>
      </section>
    '''
  ,
    title: "Container + 1"
    description: "Klassischer Vollbild Wrapper inkl. einer Spalte"
    html: '''
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <h1>Hier kommt eine Überschrift</h1>
            <p>
              Hier kommt der entsprechende Inhalt zu dieser eben erwähnten Überschrift
            </p>
          </div>
        </div>
      </div>
    '''
  ,
    title: "Container + 2:1"
    description: "Klassischer Vollbild Wrapper inkl. zwei Spalten"
    html: '''
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <h1>Hier kommt eine Überschrift</h1>
          </div>
          <div class="col-md-4">
            <h3>Hier kommt eine Überschrift</h3>
            <p>
              <img src="http://placehold.it/640x480" class="img-responsive" />
            </p>
            <p>
              Hier kommt der entsprechende Inhalt zu dieser eben erwähnten Überschrift
            </p>
          </div>
          <div class="col-md-8">
            <h3>Hier kommt eine Überschrift</h3>
            <p>
              Hier kommt der entsprechende Inhalt zu dieser eben erwähnten Überschrift
            </p>
          </div>
        </div>
      </div>
    '''
  ,
    title: "2:1"
    description: "Zwei Spalten"
    html: '''
      <div class="row">
        <div class="col-md-12">
          <h1>Hier kommt eine Überschrift</h1>
        </div>
        <div class="col-md-4">
          <h3>Hier kommt eine Überschrift</h3>
          <p>
            <img src="http://placehold.it/640x480" class="img-responsive" />
          </p>
          <p>
            Hier kommt der entsprechende Inhalt zu dieser eben erwähnten Überschrift
          </p>
        </div>
        <div class="col-md-8">
          <h3>Hier kommt eine Überschrift</h3>
          <p>
            Hier kommt der entsprechende Inhalt zu dieser eben erwähnten Überschrift
          </p>
        </div>
      </div>
    '''
  ,
    title: "3:3:3:3"
    description: "Vier Spalten"
    html: '''
      <div class="row">
        <div class="col-md-12">
          <h1>Hier kommt eine Überschrift</h1>
          <p class="lead">Hier kommt ein kurzer Einführungstext für die komplette Seite</p>
        </div>
        <div class="col-md-3">
          <h3>Hier kommt eine Überschrift</h3>
          <p>
            <img src="http://placehold.it/640x480" class="img-responsive" />
          </p>
          <p>
            Hier kommt der entsprechende Inhalt zu dieser eben erwähnten Überschrift
          </p>
        </div>
        <div class="col-md-3">
          <h3>Hier kommt eine Überschrift</h3>
          <p>
            <img src="http://placehold.it/640x480" class="img-responsive" />
          </p>
          <p>
            Hier kommt der entsprechende Inhalt zu dieser eben erwähnten Überschrift
          </p>
        </div>
        <div class="col-md-3">
          <h3>Hier kommt eine Überschrift</h3>
          <p>
            <img src="http://placehold.it/640x480" class="img-responsive" />
          </p>
          <p>
            Hier kommt der entsprechende Inhalt zu dieser eben erwähnten Überschrift
          </p>
        </div>
        <div class="col-md-3">
          <h3>Hier kommt eine Überschrift</h3>
          <p>
            <img src="http://placehold.it/640x480" class="img-responsive" />
          </p>
          <p>
            Hier kommt der entsprechende Inhalt zu dieser eben erwähnten Überschrift
          </p>
        </div>
      </div>
    '''
  ]
