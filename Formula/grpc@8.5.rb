# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT85 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.83.1.tgz"
  sha256 "cb06519b1382f57ba6f5358504cb37e933d5a5892553300877fd4f3b04cf0560"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "0bc2a7ff2d58203074bbc233e7ff13f4cec1c05dc09b5efd55f539ee203cdc6d"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b4be7371701e454a6454b89eee2255d76d29739f7eab5088f74512d49bf485ef"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "49dbcdee525bea8cf591f0018a24ba55e4df4828dfbc22ade4360b3f7d13fb3a"
    sha256 cellar: :any,                 arm64_linux:   "9d3879d32ed9945867d3fce059f9c2e4a47200b09f3bc91b1b196b868bbdc380"
    sha256 cellar: :any,                 x86_64_linux:  "2baaaf9c37620c97dca7677e1d3d2fd86738fbcfc837b79b9e8e6302e83ca8a2"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    patch_spl_symbols
    inreplace "src/php/ext/grpc/call.c", "zend_exception_get_default(TSRMLS_C)", "zend_ce_exception"
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
