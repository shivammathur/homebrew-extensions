# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT70 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8c78854330c9c1544adf5e0e165830db1aa02eca5bc4aa3601bc12d22d62528b"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2a679baa6c2fda338b414d8270820d629361aefa4e975351ddb4877bfafa2f25"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "f2f533c0241149ba64bfe7981eb1481de7921b8281237892a5ed89e40ac08e62"
    sha256 cellar: :any_skip_relocation, ventura:       "0517079e4b34da8436db4b77ab01fb5455a8a5a135fb3d87c9629d665768d3da"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "40f3cb6d83c843e2d92246618c44322ab3bc51646f98fc56ebbd1e999b36ed86"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3936ce9d0511418b548dcd0411e2efda41445d38d1eec305a5389698ab7613d5"
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
