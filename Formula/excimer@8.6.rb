# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Excimer Extension
class ExcimerAT86 < AbstractPhpExtension
  init
  desc "Excimer PHP extension"
  homepage "https://www.mediawiki.org/wiki/Excimer"
  url "https://pecl.php.net/get/excimer-1.2.6.tgz"
  sha256 "7b5fe1f68f2b1a62bd0394d4bf165eafe6b7ceb3fc20ab885e733d356db0d034"
  license "Apache-2.0"
  revision 1

  livecheck do
    url "https://pecl.php.net/rest/r/excimer/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "feafe12d5b5f5d29ebe81670d8f18c1509e3a316240040e8b8005a43c8daaa88"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "58a36573aeb18898c13221a1e27d962c41598640b8c8d8bedf8ced1aae141e29"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0a6d9122bb4a59653e89951674e32e880f2bb73a0b2b2d5d57612cdbf0928567"
    sha256 cellar: :any_skip_relocation, sonoma:        "d91e47136d2257a4f2b813b70f6337e99f48b69b7ce158b736c8788576b9275f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "57e608c5282abad248fede488ad0fb10581b97a3f1ddd20c3281009ef168b1bf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cefe6df624567b82c35f4d0a4cb70072e67ff62f7d694918d7bf51ad2f162e42"
  end

  def install
    Dir.chdir "excimer-#{version}"
    inreplace "excimer.c", "INI_INT(", "zend_ini_long_literal("
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-excimer"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
