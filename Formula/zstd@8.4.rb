# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT84 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "0d401b829ba7f696dd59e8ad5dce2e3c784202c9de07cfc731c7ab94e3bce94b"
    sha256 cellar: :any,                 arm64_sonoma:  "7f528888de9d26f97b9b3458a74876b9ae6c3eb2b587a5b5e617de7f54e9d9ae"
    sha256 cellar: :any,                 arm64_ventura: "1bbd60e94fb8618b0641cfc079bb5785e8531a6008c3383b8550c3875fc78436"
    sha256 cellar: :any,                 ventura:       "cd0e14d74f10a856aae4f6a9f04c277d05bbc7e9c8a4a2ad49b27aca4cfd114c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7d55f79c7399991fac986921e5a5cbb010bce9795eff107efc3dedf168f7fff5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1760764530e41932e44a622befa8a753251fc6b64dcb97541add823d95fe63e3"
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
