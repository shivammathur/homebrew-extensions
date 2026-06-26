# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.81.1.tgz"
  sha256 "3c9086743a29bda3b5bd323e31f9c6da6e04900288ab37f0da1df8859a2ee8f5"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "52d3616c716295b2700ce47a9fac73f4a080cccf2020476aeef5da10f880fe9b"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6d88e8cf90e165ef990ef1407448a8611b0aa83608b00c4106cacaff2dc9f79a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "807453205eef2b757026a4ed0b0d780953c96168a4bc3a3bff561550bcbd27ca"
    sha256 cellar: :any_skip_relocation, sonoma:        "ec30b57f357560f4a0d85e3fb23f90dd77b82cc8ff16ed28b69f1a59f7783f0b"
    sha256 cellar: :any,                 arm64_linux:   "b8db139916187d192aca87886f1e31a48db4db87ce1cc75a8c6d9f90cd63a6c3"
    sha256 cellar: :any,                 x86_64_linux:  "f10282a24af0a983c0b216ddf89b29901717223519b1895c3a554494d4977594"
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
