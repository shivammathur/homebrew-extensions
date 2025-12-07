# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT71 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.28.tgz"
  sha256 "ca9c1820810a168786f8048a4c3f8c9e3fd941407ad1553259fb2e30b5f057bf"
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "8994b47b604e51965af75a5d16e6768ad7cd91b58969f8dbca3caf2f97da6d53"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e50f34f60c66bb5d28ebb3d1c6be8e5824d1af4b5324b7d324bb15ce895592bd"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "9d6adcd8b8d8a20156ea3c53a9977cd2ed038e5d98ffc40dc386adf186c7e0a4"
    sha256 cellar: :any_skip_relocation, sonoma:        "f4b7abc1e985d415c018325984b7cfc25f4b795f1f8a2cf584d232915372682e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "80eff6f09577e8c0711207d9551d3b317620962fffac09b819bdfa3cc1294f62"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "205b5217e5cad8e8c6aaa785e5d7ff6572846fcb5f55c84e589a4e7dc39c156e"
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
