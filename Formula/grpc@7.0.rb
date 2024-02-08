# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.61.0.tgz"
  sha256 "7efeff25faac9b8d92b3dc92e6c1e317e75d40a10bdc90bb3d91f2bf3aadf102"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "7b12f328f25c9ce2ecab47229dcff66bcaf9d74cf8654db3c5476e6f38a02d01"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "645727a863b9cc244e87a89d3658cfda81106adf82711c0d17ffe17587a0a09c"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8576c90730037d16a9b5710ba2437193b7826c40b3a57f49721ac948f8e429e5"
    sha256 cellar: :any_skip_relocation, ventura:        "d6ea818b65439201deaf946fbd8fc7f89b5ba10ab477edf8bc7fbebd921f08ed"
    sha256 cellar: :any_skip_relocation, monterey:       "a80d2b0fae06f0ce9985449b94750ea1731b04ca6e08db43c838325d35a5e5de"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "665daa83ffc9da0827eb089c678aed87acc76fcd3ccf2d633cc7da0e426b330d"
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
