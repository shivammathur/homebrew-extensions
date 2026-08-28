# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT84 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "e3fc8e4192c3876dd24b5c4baf3ff4b29031d53abf8d4c2a5c8f23f2bfb2534e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "0acc0fc122f2211da6fbe8a83f16abbb1f7378552fa4a62965363a1d4c5188be"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c6e44fc0338f48578a141d5aba84bc3976e186e92311afec952b927868957f82"
    sha256 cellar: :any_skip_relocation, sonoma:        "0e80d788b98d6c018db1c4f14f64f782e71247551d696ca24b82c89ad33be98d"
    sha256 cellar: :any,                 arm64_linux:   "30ade135c3e155d6fcea806a68577aac08261cecc8bd20dd8ca829c293720a9b"
    sha256 cellar: :any,                 x86_64_linux:  "a4841efc5ba02f4b313e83545da495d00c31916fe0e5c3aa857bfd7563f063f7"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
