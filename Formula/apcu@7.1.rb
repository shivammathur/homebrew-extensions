# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT71 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.26.tgz"
  sha256 "aed8d359d98c33723b65e4ba58e5422e5cf794c54fbd2241be31f83a49b44dde"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "5439a9061ce3d9fa52b1543062ea7e936c514fba25f96154e10874503e5821f8"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3c88eadf7432beaf9c3f62622c66d19ce32584687657339a0ba8ea7cdd213d89"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "47c1d911adee84700e2e5091e7f9aab146062c0b89948f8100ad741557c70355"
    sha256 cellar: :any_skip_relocation, ventura:       "63c46d2254008add452b3e4cd7297ed1f4ddd659279f02b14409520eac72fd0c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e8c75b13416688bb021f719c4a1417cb824ae11058bfa0c829c019a1aed66952"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3924e1adb6a6c879e61ef5f7ef1275f98c754c949982cae29350974356a17dd9"
  end

  def install
    Dir.chdir "apcu-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
