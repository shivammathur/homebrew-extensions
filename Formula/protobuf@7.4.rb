require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class ProtobufAT74 < AbstractPhp74Extension
  init
  desc "Protobuf PHP extension"
  homepage "https://github.com/protocolbuffers/protobuf"
  url "https://pecl.php.net/get/protobuf-3.12.3.tgz"
  sha256 "056b815dea3067abf8fe3d7779b2357039129dd847f66b49b80c9ab05d7557a0"
  head "https://github.com/protocolbuffers/protobuf.git"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    cellar :any_skip_relocation
    sha256 "7e1a8267720355767aef73f14242497af082bc1a659fc4a9a09089c300a27e9c" => :catalina
  end

  def install
    Dir.chdir "protobuf-#{version}"
    safe_phpize
    system "./configure", "--enable-protobuf"
    system "make"
    prefix.install "modules/protobuf.so"
    write_config_file
  end
end
