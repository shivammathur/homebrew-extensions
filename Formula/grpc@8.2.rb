# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.83.1.tgz"
  sha256 "cb06519b1382f57ba6f5358504cb37e933d5a5892553300877fd4f3b04cf0560"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "9e59640792991cb1349333f7e34af5fcebc54e782edde0aa6216b01d3190407b"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4836624adc4b7f8bed03b5a0a22be036e3da522c9c224c3ca70301a915361870"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "dbbb7ea696ce012c2786feb84581e52e839616980152d431164f32f44a32a741"
    sha256 cellar: :any,                 arm64_linux:   "7e49780fbd1b29604443bbf94aaa293a98c82ae2808ec321cb29174125638645"
    sha256 cellar: :any,                 x86_64_linux:  "22996fe76d51f992082a65e3e23e43042ecc287bb4a85e64a71925304d5c24e7"
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
