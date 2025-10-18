# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "feb4e6bc17aa674f158f6ed6969c6b194d5ca83844c1058361bf89a90659d893"
    sha256 cellar: :any,                 arm64_sonoma:  "9bfb803f6e284fad17e74b486ead49052fb3293438e3a804d17fef3360db547f"
    sha256 cellar: :any,                 arm64_ventura: "d85e0e8413c1f43406d4d39e9a3cd1b0fad9296a8888875dc22b4cf33104599b"
    sha256 cellar: :any,                 ventura:       "b156b2176db74cfa08e8915464e928d74c5d0fb6cf3e4fc544fda2ef8cd6d689"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "8bc225b280300f7ee3feea2c61859708d8f3cf9bf8c92d0816730f9ec17481d2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "420e9a0c447fd90d0c77a8b86711390bda8edb641741eb7ed5c8c8f8072b2207"
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
