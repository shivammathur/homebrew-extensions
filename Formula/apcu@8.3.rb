# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT83 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.21.tgz"
  sha256 "1033530448696ee7cadec85050f6df5135fb1330072ef2a74569392acfecfbc1"
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "0297bbe3d40ef89b813fe18d80124b8e3460d4d4260c07e022a06c220d3142b2"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "6215caa7722a9494c587edbda5526f6edd31d9f19d2d61061a857614c68216d6"
    sha256 cellar: :any_skip_relocation, monterey:       "e1823d04b1694d9abc749ff8905fe9786b0f9c9b79b50c14d024fcada456c254"
    sha256 cellar: :any_skip_relocation, big_sur:        "263f1a5dbdfb95bb8f5a9f37f9be5bdee61b450484ddaa25bbe82b4ded31b1e4"
    sha256 cellar: :any_skip_relocation, catalina:       "f285489f44189dea1983f1479f9ca7815cae8988b0e012d0c6e9bae7d2d17d85"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4d69be1bb360b861c3db5fb31cff346ca8b5137cf9c8fdaae79b04360eb336b4"
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
