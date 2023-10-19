# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.59.1.tgz"
  sha256 "d789aab7c791647907c3bc3af2bd6b6e97348d1b50eaa59826be61c4a3c3d3ee"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "e26f41f163755dce3eecdfde93216153b706e677f23c8664c698aa8378f62826"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "9494726010ea0a795353f38fa870497c195ae3f7f73a8ad3ae761500347dc903"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "f9ac16bc1b273db280731c7d0a3869e5bef073bcd8b8d3d7527e826a41973a7a"
    sha256 cellar: :any_skip_relocation, ventura:        "bcaef98cfd3669a147c640b5e6791e2a318714effaac29b0f717d1d8a551d12a"
    sha256 cellar: :any_skip_relocation, monterey:       "3501802a34a54ee840c8255eacd82fa773f0c0c1fee8e4a1cd10aa3fbf8587c4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2d6953a7f420127a65da1498d9bbac26676c801f584e22b3096177104d78a263"
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
