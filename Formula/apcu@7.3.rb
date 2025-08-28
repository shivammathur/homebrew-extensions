# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT73 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9e85e69ff25f2d1d3315086547915ba05b09e16652b136579ca9de1aa70f10dd"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a6a00a9fff4d1e941554c1030aa851baaaab2cb6d9565530ff8a5a188b5f0f42"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "00cc7b3f28e43fec7622545d40dc18fa7f27044611b5354ef3deaece56a4365d"
    sha256 cellar: :any_skip_relocation, ventura:       "8abf916151299337e3fea84d66773c3471828d253e1281e0c52bd6ea20e25e7e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9204209675cc2aeb420fb3cf07a8308fc860ba452f11840254602a30b540163e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b8f60fbf5634d9e791faa60de2662009ff9109021363b2ea0519802d11fcf498"
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
