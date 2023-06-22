# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.56.0.tgz"
  sha256 "bb3c58314cc4c4c043b70bf7162a4ebae507834bf5c2a014b67ebd8d70109dfe"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "cc38f96a8a6e1ceaaf9aecb37958f86f73f22759b48d2422a688f2412ca98970"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "e338d9579f300236d5e7c0a32a9ffea6e2ced34480deacf119ee06cd74e90b5e"
    sha256 cellar: :any_skip_relocation, ventura:        "2fe1be60c4d87d6cecbd64c6b75f118c36695769b109813e6cf202be01f927d2"
    sha256 cellar: :any_skip_relocation, monterey:       "dabd24ee76d91401f18ea2abbc09dd9dd1df5190bbcacba6432917d64ff298cf"
    sha256 cellar: :any_skip_relocation, big_sur:        "e8e2640da176c74b15094d490981a91c52cffbb2c61dc36350ab543bc2e0dbe2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "39f868ecb34e24224b3a6fbcbbb0df1d3ece6887c9ee4ddf91818e98a8a464e1"
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
