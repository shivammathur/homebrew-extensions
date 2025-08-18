# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT85 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.15.1.tgz"
  sha256 "5dd4358a14fca60c41bd35bf9ec810b8ece07b67615dd1a756d976475bb04abe"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "50d55f6b8274f3dd5e09caa4f0da3af4e346adb6e573bb9bcb9137b98a2ddf00"
    sha256 cellar: :any,                 arm64_sonoma:  "74c2457e3af0d0fe3fd3a9a09b0cea05b6c9e3737df19ebd056424d7638fe704"
    sha256 cellar: :any,                 arm64_ventura: "fff4943e273afc61fc4a11eb2a2049b467404550b569bdeb69ad9b1c81bd4d3d"
    sha256 cellar: :any,                 ventura:       "861d48121b81dcf577260835a8e29a6cc15cb448ca93050703fdddc0c8b57d6d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "43299ce7863f44e449f3bf9f612528a30f8571559d06f7d06e384fc7a258851e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ce7a99a1899f18230a51a356d84237b9d4395985d63058eae9cd03bda31943e5"
  end

  depends_on "zstd"

  def install
    Dir.chdir "zstd-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-libzstd", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
