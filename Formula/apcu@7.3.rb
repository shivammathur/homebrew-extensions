# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT73 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4395cd4804f86e464255799ab7f361f12ff6f254e58522c554be683ac4939417"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a7927a94eea686654704b1b7f94fa0425a5921ddca3b637fc93e8e2310412438"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "01dd75f095ef0dfcb6a5c4def908cf304fa12da9f57797581ea5abe5733b424d"
    sha256 cellar: :any_skip_relocation, ventura:       "02e76259403fab8758ed34138383d61207b20382e3f781bbe6212efd8471607f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "59a8e911a8c08dbf249d431577c9a3f3c4b25f0b65fef4130fb2bc9a9a853966"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ecbd068c3f7cebe95acef3c693d8b5c83ae4d6b3b1a7cac29673a52dd95d546b"
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
