# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT80 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "3c34b0ec9974e2ec07ec9612fb250b7dfe074419f10ba6965dfd013a8478d2f5"
    sha256 cellar: :any,                 arm64_sonoma:  "e3b929c6b498c2ff9b94ae94cef64f655b9a959ef37cbadd08847cc9523c6732"
    sha256 cellar: :any,                 arm64_ventura: "20ec2af190cf7caeb0bc68eba21cacf98931f1148c80b202587b105001ba269b"
    sha256 cellar: :any,                 ventura:       "0d4cdf8b008bcc5fae8265fbd9840f40a56116c540184918e114c00d4fe5d771"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c7a6c6ec4c85efe528954759b0f9a910214e7f69bc1068fb0eb81d42f0f76a13"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b0d49ea17f1ab294be34ad1243cd7fd16ed98c62b3a91e7f967bf848176ff628"
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
