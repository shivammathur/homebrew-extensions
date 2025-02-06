# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.70.0.tgz"
  sha256 "11336d7bc4465148db506348006dd5559ce478eee4bf1b080bb31b89de6974b7"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "594bf8c69876191b4949099b0581628884cae7de4a04c7cb2445c19344504a2a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "305ba3aff61e3dd4db05589bf536cf3fed25022236fbb83511257f64b14862e1"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "6c517e87e0cac1cd5ca64dcd7dfd5b637afbc350d43912e7af08aebfa3202c1b"
    sha256 cellar: :any_skip_relocation, ventura:       "27de19df3ad572dea8b6d453f16f50c6ca59d44fdf4344345b721ece18b9f1ee"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2ed12fa5f9c4b75569fb42f6304c3458676a6f5d18f040059ffc474a110a3a64"
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
