# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT84 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.66.0.tgz"
  sha256 "6f6b751bbf33a88f917ca11a5b32923223c106eb5f064b791f99c6f7a9c7e7c2"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "e051343a132e2dfb712b744730a8c7c3aa82a7a1a3ca95dc69c6ce27a60c6615"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "c653961ded4ec7786ede36bd0f25b2ee52f45b905280ae5e15f897a1b43b6979"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "f82cac3d19ba912ab96b99dad0971479df16a4a70aa01ddbb80e1ead7be69425"
    sha256 cellar: :any_skip_relocation, ventura:        "5af75eb0c5cb0935e178ce581c609490d2bab5721978e4e4d9cf0acb2406c7c7"
    sha256 cellar: :any_skip_relocation, monterey:       "3cfc2ff3d3988fac5092e0b917e25ffce829c969102d2f5965bb6b180199e724"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3b42b4f2ecdb6745cb55834547d755731c84cbca3fd409f8e546ee5620955914"
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
