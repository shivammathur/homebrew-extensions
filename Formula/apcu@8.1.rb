# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT81 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.27.tgz"
  sha256 "1a2c37fcad2ae2a1aea779cd6ca9353d8b38d4e27dde2327c52ff3892dfadb3f"
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "964c3591f8f5c80390a64250f15f0a0351c6a73d606ec627f32dfc60023b029d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "35fc296831ff9aceb39cabcd9e5736504ea36ee1091c3a13a868abc7263e3425"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "cd4c4a64392877543cc19ecee63f957102b3f625308c4cb4b6f29fca46b03463"
    sha256 cellar: :any_skip_relocation, ventura:       "85359c8f270cb08fefe9440a7524d6f79df6a902ea42da64dac35ddf36bd2383"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "8bc8771d69da5e731755a97302d61b1fec725e8db458e1db651d30292f68b882"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0495eba18935225410bca3537aef4897c232c8233a3485235ec8a446c1857b34"
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
