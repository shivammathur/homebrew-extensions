# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT72 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7bb2268c9f3a2b3d1bdae779c15ab848564b43b289ed3de7971d86195562779b"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "012ebfb28ea3b88b465136e9ea2c6270341d7154db35870c1c82f5b85fd251cc"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "27f983909faf97cd28a4ef507e19895bed2dd095ac8d48299233e373feadbfa5"
    sha256 cellar: :any_skip_relocation, ventura:       "c042bd1a3d49ea528c9ff5d8ba4bb85050c6f7ee9617aa78958bac2cf635f360"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "32014a21b7cffc9f36645424a31107e915b64d27026dd21a02cd45d112ef7a9c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "95fae662130ab5a2ecf378d7291afa808d3325896a202067a926a75c2ec56924"
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
