# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "ee805ae2c775036b6e9f6d8e15be071bb1e53e6ba02d56359335d7f124bbfaea"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "93ef6aa5f8042a574dd537430c1c9f6792e9b3cf76643bbfa153beb237125a86"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "87f157dda10f3b0aa10dd3aa3aaf85866617b3600472e0cdb84e972c7c515107"
    sha256 cellar: :any_skip_relocation, sonoma:        "b11e1be10adef105ac24876775c75a0b030b8a3519454b0c3b0ac004fcf8c6fd"
    sha256 cellar: :any,                 arm64_linux:   "fb7ca90a316a8ea506986220d79e99e461cd25caa10dbeb23dac6bae62d87d35"
    sha256 cellar: :any,                 x86_64_linux:  "eef5ee3a9f1575158a9822615eba23cfddfc454ce5b5aa6da1dc7dc0eb5cd387"
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
