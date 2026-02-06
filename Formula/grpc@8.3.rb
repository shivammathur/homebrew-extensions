# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT83 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.78.0.tgz"
  sha256 "c846ac9164930897fea9c55bad52aeb9f99a03cce64e694bd80f781c59baa0a8"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "c19cf0a4974f9eb196a5f21e96144360968db0a63e700651f3fa3fe5ddd1c0fe"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "023c74096b560150100d122ecd6e42362054ef4b691b09cc80e28669a01021d8"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "02982cda9e72e9db7693a8364296121d06d71e651e985b078ddc81721e2010d5"
    sha256 cellar: :any_skip_relocation, sonoma:        "571befb3438a0104f33015fb2b7131c6627e101b19d1548ad2ffe2008eb461ae"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "857dd23a14252717c15dab4bda5a2fcb81319a8a1eeb660402311205ea5a2072"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "11b3faf99a9ca1ab6518a4fc68290a779bc446b6ca9db283c59c29c575456d46"
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
