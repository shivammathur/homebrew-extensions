# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT71 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.4.tgz"
  sha256 "1b16ae5e17736e2ce892fd96145fa8b9e1724106458535d0c7e3d4093a9091a9"
  head "https://github.com/php/pecl-networking-gearman.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/gearman/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "5442aa6fd9d3aa3bf2ea5ee170a21d1a1a1d9589333ae66454df3f93275afd83"
    sha256 cellar: :any,                 arm64_sonoma:  "fa1007ee64a8de344b502b13cccf055fb010b9983c6bb85f2d15ae768f16b2ab"
    sha256 cellar: :any,                 arm64_ventura: "be84122ab1bb57bd2223d80f6adab4416660a88584bc1fd4e49e40e02322a3fe"
    sha256 cellar: :any,                 ventura:       "85f84fe4134c8216b29c18b5b01ad7d57ac1b5cc2e576a94d7323a79ed48c203"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9da928db36ca14cd9e100ce4c52956fd4af3419fae6ca5f3d15f779764abe1b2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4cab98128f6672d2b1aeca70d1f681c52258ddb2a41cd731550595931e527393"
  end

  depends_on "gearman"

  def install
    args = %W[
      --with-gearman=#{Formula["gearman"].opt_prefix}
    ]
    Dir.chdir "gearman-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
