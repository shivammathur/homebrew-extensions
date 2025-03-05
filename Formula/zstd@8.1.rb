# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT81 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.14.0.tgz"
  sha256 "207a87de60e3a9eb7993d2fc1a2ce88f854330ef29d210f552a60eb4cf3db79c"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "fbbb8b9947b9632e161266ebb1b07c3c7a11bafe44fdd39c13b7322e11597f65"
    sha256 cellar: :any,                 arm64_sonoma:  "5328e0a72aa6342cb96a11520c22b902860b58804792c5c26cc151be5e582c05"
    sha256 cellar: :any,                 arm64_ventura: "7348a46fbf23d52bf9fcc8cced2276caa3de76ef40b122ab4a860bca49664cc3"
    sha256 cellar: :any,                 ventura:       "387b628e256ddd1577811337892b3722760e738a8108b146fdb6f114c28e3d7d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "66645c630f6c5dcf579bae788dab8d43f3d276900dcda333ad80f41e120d1cd0"
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
