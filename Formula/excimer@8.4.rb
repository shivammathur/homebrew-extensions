# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Excimer Extension
class ExcimerAT84 < AbstractPhpExtension
  init
  desc "Excimer PHP extension"
  homepage "https://www.mediawiki.org/wiki/Excimer"
  url "https://pecl.php.net/get/excimer-1.2.6.tgz"
  sha256 "7b5fe1f68f2b1a62bd0394d4bf165eafe6b7ceb3fc20ab885e733d356db0d034"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/excimer/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "4925c3fd28adec17c7713b5be89a65f3249d00839c38c7a931925249366dd4b0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "11fe8ed71f75e4a76490bdf2ceaef69b1659478ec9be90a81a7020170c961af5"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d879a895295a57f6fb74c8018b97a034421ce42cc8ba8b69243e228a55bf3a08"
    sha256 cellar: :any_skip_relocation, sonoma:        "79117b63bdf03768638dac474b799a84f7c0eac38eabda6cb9c73816be642aab"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a0a8d1307158bc53b5b385766db6cae21d6bce08852216ded381aa8b5d862785"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b045244809dc93fc6e5f10f1f3208c81ad3b6a3b523b8790490a78be792a34c7"
  end

  def install
    Dir.chdir "excimer-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-excimer"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
