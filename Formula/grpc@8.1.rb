# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.63.0.tgz"
  sha256 "0d67d0935f1e4a1feabf96a64f24e32af1918cd09ea7bef89211520f938007ca"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "c39012aa1552479d1e6ba5cc34677134e080d31a3374752458057f66a098d092"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "4f4f1d5de9f7558d67c341a4699f2f31118e4d5bb5bee29eb05534907b0a405c"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "cd81bb3c8d55183fbcdca47edd53b7de742d46572948e36cd876a77003c447d6"
    sha256 cellar: :any_skip_relocation, ventura:        "d5c226c1a35a754d72ea412e417e0ea7ce3d2e288f8cb758fde3abe084f091c2"
    sha256 cellar: :any_skip_relocation, monterey:       "34e43d443bcd707c6ae374caa04821385398dbcd2b519ee584ffd386f0263017"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "31b3baee483cc2e9ff12a62730ac150f58be2188a392d766037288d014d190a6"
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
