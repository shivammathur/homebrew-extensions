# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.74.0.tgz"
  sha256 "972ce8a989f2c15a951444950c1febe84eb88e59aeaca29d96e005fe55df1fc3"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "408b709e99db9cdf97b50982cfc18b24d6741675e12671c34193946cc10e8dce"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "007dd3e32c55af5b7105013fe8fc818cd061e499eb936bc41ec01401730d193f"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "68cf08224bdf21ddbd0c17946f1c7c02ec79f5a129f6f02017000bf7f9ee360d"
    sha256 cellar: :any_skip_relocation, ventura:       "1490d3b0e2aa5bed8834dc54105fc19b4c08260999652ea52fd057b18f3a9000"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "cc8dfc530dac881517057441e896d11c2565b322d9b71cbec8139fb65cfa4ba7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1d91726f5a6dedbb9d023f13257488a8eb4e84d9d2fe19b889d59cdea36b5a13"
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
