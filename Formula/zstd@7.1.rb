# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT71 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.15.2.tgz"
  sha256 "fd8d3fbf7344854feb169cf3f1e6698ed22825d35a3a5229fe320c8053306eaf"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "bf2cb30aa2afeccb40fc5bac698c23023bec57f3d30e3c2b7f31d40a3f1d76b9"
    sha256 cellar: :any,                 arm64_sonoma:  "74d9a4169d5b89e95072ec48e2c5ccc3bbcca0fef9b04d0c9ae26e3300be82ae"
    sha256 cellar: :any,                 arm64_ventura: "b059e3de9c0daa433ad014bb0984e78bd989e390e3b9f4efe782f4c7d562926c"
    sha256 cellar: :any,                 ventura:       "f2a794f22d5c4bae04040a1334c5fd2682b8f4efbea635c7ac3b9ec208bc9bb8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "160d7b7a52d6cb94a6f143ef287d0333b39639810291d93088bff9df722292e2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7b3e4323a6d4abe40b9a7b4f309462230d26505db65d5005a8b399b95625a9e7"
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
