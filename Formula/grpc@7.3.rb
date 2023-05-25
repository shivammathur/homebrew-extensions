# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.55.0.tgz"
  sha256 "75f9a465a4d1f6f337aa5dd83e5b5447064aa0a2b2776a72ec192ad7972c8295"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "4df3e28e13e02ddae466b87fe3b900345244fc71561d210431945f54114af340"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "adebd2b746a0d932808db2c46a032a87ec2e3c1c119eb3251a1c32dedb1f72d1"
    sha256 cellar: :any_skip_relocation, ventura:        "d6d251af11f98a49aa124c1d6bff261298ab10bf47cb64bfc99f5e17e285888f"
    sha256 cellar: :any_skip_relocation, monterey:       "5edd49e7fca4123feb1f851ca7cf9137d130eb4c13443a63d5c0d9467a9c6d22"
    sha256 cellar: :any_skip_relocation, big_sur:        "51a2e48c679f43aba5a1d608482ef0684be75a8665f5841e155f6451f7819be8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "13351bf104640362ef652af9bd56e3f17e0ef661bacd334d3dc808f007543c32"
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
