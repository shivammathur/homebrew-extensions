# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT84 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.81.1.tgz"
  sha256 "3c9086743a29bda3b5bd323e31f9c6da6e04900288ab37f0da1df8859a2ee8f5"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "470dd8441d69ff7b42248479e00f6a96144b1986dd07f0f1fde08d502e66bc50"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "04a4943b606bb79d479ce5fef4ab1c9ac07f540e7093f8895214d554b7263287"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "33345dbd7a5af40ef9125c1c8befb98478cc8ce2475812b413c66e4fa715c9bf"
    sha256 cellar: :any_skip_relocation, sonoma:        "7fc4532213cc34129754c0a45bce8b1f2f96d939e8a1e012830be26caa4ed22b"
    sha256 cellar: :any,                 arm64_linux:   "261ea8e3197dd14faf06f4eb45f386e7b1e513d0ffe7e30113672606702b1b84"
    sha256 cellar: :any,                 x86_64_linux:  "db72a1ecde092a3e4ab847b93c7b1fe6c5311a2a20a8705b1126277894931fcf"
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
