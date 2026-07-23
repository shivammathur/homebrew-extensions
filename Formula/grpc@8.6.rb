# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT86 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.83.0.tgz"
  sha256 "b12c7e0e048df728a4f2c513aeaa78ae18ad5c3ab3b607eeae398e0e1bab12ea"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "a1914b11dd8ca9592a788f4dc22505c4153b03ac113d07a660d3424ce084e611"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "872cac2dc139fd2c81b09252467adad6a5e7cd04cec3fabcf0a5c2dd97abc725"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "92a400b1ac043d563d7cb3c64f7c85f6d3abf77dafb55f71217c4e1647488dbe"
    sha256 cellar: :any_skip_relocation, sonoma:        "dded57665b9437309666bb358236d7a5743174647b4c76a8fd3a1d993e4d1578"
    sha256 cellar: :any,                 arm64_linux:   "0000cc3ef05b9635048d751dce9836cff7e968fe6e1cd6b54c5839ae899b955c"
    sha256 cellar: :any,                 x86_64_linux:  "aa9da3f33e5577119c37da2344f3517e587676301e1abf7cf4777b008534f3b2"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    patch_spl_symbols
    inreplace "src/php/ext/grpc/call.c", "zend_exception_get_default(TSRMLS_C)", "zend_ce_exception"
    promise_factory = "src/core/lib/promise/detail/promise_factory.h"
    if File.read(promise_factory).include?("GPR_ATTRIBUTE_ALWAYS_INLINE_FUNCTION\n    absl::enable_if_t")
      inreplace promise_factory do |s|
        s.gsub! "GPR_ATTRIBUTE_ALWAYS_INLINE_FUNCTION\n    absl::enable_if_t",
                "GPR_ATTRIBUTE_ALWAYS_INLINE_FUNCTION inline\n    absl::enable_if_t"
      end
    end
    inreplace "src/core/lib/promise/try_seq.h" do |s|
      s.gsub! "GPR_ATTRIBUTE_ALWAYS_INLINE_FUNCTION auto TrySeq",
              "GPR_ATTRIBUTE_ALWAYS_INLINE_FUNCTION inline auto TrySeq"
    end
    loop_h = "src/core/lib/promise/loop.h"
    if File.read(loop_h).include?("GPR_NO_UNIQUE_ADDRESS union {")
      inreplace loop_h, "GPR_NO_UNIQUE_ADDRESS union {", "union {"
    end
    inreplace %w[
      src/php/ext/grpc/call.h
      src/php/ext/grpc/call_credentials.h
      src/php/ext/grpc/channel.h
      src/php/ext/grpc/channel_credentials.h
      src/php/ext/grpc/php7_wrapper.h
      src/php/ext/grpc/server.h
      src/php/ext/grpc/server_credentials.h
      src/php/ext/grpc/timeval.h
    ], "XtOffsetOf", "offsetof"
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
