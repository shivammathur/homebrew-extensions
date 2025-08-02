# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT72 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "dd740bcba020472203ef14f1e1d8494795a1c90415c042128d635d618f34e835"
    sha256 cellar: :any,                 arm64_sonoma:  "fe256cc785c0a465f859481c2a1f10ecf4d39db67d600ad2ce439e5966ddc8d8"
    sha256 cellar: :any,                 arm64_ventura: "da2a85d45f02efc72bc3f1afa22de691ae98dee721010bead82fde0f6c1f3478"
    sha256 cellar: :any,                 ventura:       "d9eeb3b7993076ee19f02e3208d07cddc657452d429f18b5c9c339887d0922e6"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "cfdab7a6b781cccf856f5466c9c72283fa5a7fa3e936370722bba1ad9f6c4553"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a4779e3b9d9070e16aa6b264a491aca55e112a92e51b5de17871cbdf57c45053"
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
