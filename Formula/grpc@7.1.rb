# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "5672d5ab18e92bd5cd6b1869143ca9f6a3ed3a0395b1d2c99d967df2b0010da6"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "319096778182bb23967d51574c548969b58fe6c72ec2e65164f0d0121d52bd23"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "19d7a5ba5b03da87d8a831d9defc13c388cbc8fa97f32360b317c941aaa6ec3e"
    sha256 cellar: :any_skip_relocation, sonoma:        "9b9170a65fdd9bc9c4f207c4621025cb9e36b573ad13b13d8d5fe49cf7322331"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d6804f95c2bc80dc7612ad3f40599d8c82e7b617c8dc1ec6991977e6411987fc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "98d73125c5a1371aff10c4dd61ac350b4ff42e64055c7d719bae477098f825f0"
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
