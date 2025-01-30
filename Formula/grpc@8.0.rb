# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.69.0.tgz"
  sha256 "85ef59edd3517b377736c49a73799ead4729a82b960474b8842c9f89d2fbf222"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d9c3d8b667030ca18c5730e895fe7092bc795a1a40f2b7b82d453d78bb8974a1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "afc44c6849ff1b04d973e5a7cb0f681834a00e58740d8f2cf8ce4759f1587a14"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "f6627be61999f1591e150b1ad52401356e97c837b22d06f38e92af8863e23b44"
    sha256 cellar: :any_skip_relocation, ventura:       "da50f908983e4e73dace8ced9960168a4d7fd0209470bc33288404ffe9ad50d5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9fb19f9c2d4165b90f5c553ed17a9b2d4fce735ff0e9ea96dfbb8c44c8d4b358"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
