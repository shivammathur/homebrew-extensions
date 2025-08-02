# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT80 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.2.5.tgz"
  sha256 "0c751b489749fbf02071d5b0c6bfeb26c4b863c668ef89711ecf9507391bdf71"
  head "https://github.com/php/pecl-file_formats-yaml.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/yaml/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "7d0615c194d7d021e96ea3e8e9b3a60f4d9ad8f3ff036e47ed2629589335db51"
    sha256 cellar: :any,                 arm64_sonoma:  "98f37fb0953ac377a31d20dececb0e6ad0233c4d8a434f98e76e4ac6308039fc"
    sha256 cellar: :any,                 arm64_ventura: "5f8b7c8277ee5ad0df3d03285e0aa87e21437ab0c7f775546b17cea77a9fe88b"
    sha256 cellar: :any,                 ventura:       "54344288f1c8da4b6cb60e16fcfbbc9a043f189555aa187826af38a2fa00e167"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1603f968e05545c3fe3c11402b06dc7a3994b7bac91c21bd640340d91d08915e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "801a2e96c928eba0d996d273e259d45fb131abcda4bf8aa4a38c10d66686ed15"
  end

  depends_on "libyaml"

  def install
    args = %W[
      --with-yaml=#{Formula["libyaml"].opt_prefix}
    ]
    Dir.chdir "yaml-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
