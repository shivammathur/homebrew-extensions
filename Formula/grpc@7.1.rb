# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.61.0.tgz"
  sha256 "7efeff25faac9b8d92b3dc92e6c1e317e75d40a10bdc90bb3d91f2bf3aadf102"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "c7ed47b84c1b00873defead128104015b5711b4a47b48064e5b3407e6fd49a17"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "31d6dece85a0fefc3a8e728e8d74e2e62aa5b7bce8dc669b9fee000d44137522"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "524d11c106e11de9f5cec286291e96dbeaaafeaa53a626a579ca05802cc1d6cf"
    sha256 cellar: :any_skip_relocation, ventura:        "2e3df0a2c88b12e28319f878d8fae12774a468108860f127d1a31153800c5fc8"
    sha256 cellar: :any_skip_relocation, monterey:       "5b39eb83b7aa545cc3a1720265a49944b26cb2c354cae0c4c16bec3efa7cbd9a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "41e674cbcade6c829067cfc4ebca2503cc1e81adb6abb270b4f6b36a2d562679"
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
