# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.70.0.tgz"
  sha256 "11336d7bc4465148db506348006dd5559ce478eee4bf1b080bb31b89de6974b7"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "cc1916e5a256ea9e496de5a74e12ab7f3d8d2ca46ee0467eebd5ef8aead3f74e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a4eea59fe477cf2064a00c9a311c2483a802a39f6f47b0af4ef0669a10d7217c"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "cee61a3f7de9668a5ded3ee5425435127bf39fbed57db3e2e0c5c0b567d02ec3"
    sha256 cellar: :any_skip_relocation, ventura:       "8eda518ec51a859110430fb88968ae63d1cd663a9725a2d1761cbc521aa28ad7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bdbc8b8db000af26decf49b9a7845fec665cfd00b3824b416d315a1f1e6344c7"
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
