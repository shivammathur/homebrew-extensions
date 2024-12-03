# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT80 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.24.tgz"
  sha256 "5c28a55b27082c69657e25b7ecf553e2cf6b74ec3fa77d6b76f4fb982e001e43"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "edf029361fd23311471498b06f99f24fe3e16eae9c3786b2371982a370fa0fdf"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "54691b1632fdebb2667ab185843f630812165c6cd8e476252bdb2ec429ab05ac"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "def24f7a6f3f0838f4633ff42a9974ee2b707ee2abbac879eca03e0d72eb959c"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d4f51878ea214864e9738e6da9d6ba4e7df912b75b52d270300ea9528a55b2cb"
    sha256 cellar: :any_skip_relocation, ventura:        "1822191758493b36a06d6928dc8f059bc325912e9c3bafde3035c96cf97a73ce"
    sha256 cellar: :any_skip_relocation, monterey:       "49f2479aa67565f76753f7ac5e2fbd7ebfee90a8bbf9d1534fde9d9a1e736dec"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5cfda7182e1108b6bf7622a6c7ad3e073da194ac3073dba498cfaa18d649df11"
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
