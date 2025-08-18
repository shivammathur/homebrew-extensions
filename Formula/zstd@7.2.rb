# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT72 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "bb460d570cb9166c4828f791abf6596828e4e0f0a0d7e05249835732c15103c0"
    sha256 cellar: :any,                 arm64_sonoma:  "cd0f030a0f48a5a09e8d7106b07e5fd29b3d364d79dc551fab6ea59ea5d3e74e"
    sha256 cellar: :any,                 arm64_ventura: "8edb7569fad261a0f8ac92d292adb408a7eaebcf4ae1ecb112e20cc7b2ad56f7"
    sha256 cellar: :any,                 ventura:       "be02fb0548eb49efafc2287025eb2222303e2b624ff770e67d991053cb7334bf"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "621a1e34c69a31e843fcbb49bfed02e3445a228c03206bff827d35863ce7d2b1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9c65a036c55fcb60fd12dc46f081dda4dfd429d57446484aa903597b7da47327"
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
