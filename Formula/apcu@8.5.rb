# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT85 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.24.tgz"
  sha256 "5c28a55b27082c69657e25b7ecf553e2cf6b74ec3fa77d6b76f4fb982e001e43"
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2182e9110b3527c2040e335ff585c404e16c4b8585621790f20c91d03ae72e34"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5f31fd01e1c2aded317fb5a39b62c2ec049830361f0ee65d22cf21025b9813ed"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "c7063dc03385c6fc15038aa24e1a26a9b398e2c5a9949e73fb73dc278f039f23"
    sha256 cellar: :any_skip_relocation, ventura:       "ad20b2897f72b6d13711dad5d398277d00f3e2f9131225156eedb50c38e9c001"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6db4088e9e0c5a7680b2143d298e0e7a8a2b47c22e2ab1e9d0d8891cc772be62"
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
