# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT83 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.68.0.tgz"
  sha256 "4e022e052d5b7997efd42f3b67f1175dbbb772cfd435570852febc0f569065bb"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d9861ab1bd37c450d9f9007ef7e9b61ff102ca4d45c060746361f5cae655013d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1b3c73b10c453ce2b51568c48c1b1f736080101c3f3d8575e552b6cffd0730be"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "d69dd188989ca845f13b897caa63b9b98ab63b8c0c86e3e19d87fdf6f4baf22b"
    sha256 cellar: :any_skip_relocation, ventura:       "f8c126cfd7580fa1bdcba15ddc0c6f02b1a826c76f5d244562db8fd933f3081b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "198847e0c0abfa1d856868915938885c6aa20f39ab5e0e16be1288affb9985a9"
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
