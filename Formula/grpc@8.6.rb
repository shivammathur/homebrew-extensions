# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT86 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.85.4.tgz"
  sha256 "eb584cbe54ff361a54a9c0628bb3273b141e7900f5a6d89a43f97137875d7cec"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "0707853cfc887a72b9943eaaf5f06e82a44cc37160360d2062594295b44e9038"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "0a443da0a325f38860ac3bea603efcc6e02b682cd9c25cfb156972163409242f"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "562e26ce3b0a512c1164c41d7ec31ab9261f9cbb258881343d298b5f88afa19f"
    sha256 cellar: :any,                 arm64_linux:       "6dfa492f47afc133a7633357f6f27d6e0e4c54c7a5cd4b2e55581928746b36c5"
    sha256 cellar: :any,                 x86_64_linux:      "cc3d63e658546def1f7761bd7645118201c82809a16a06cd8e9a36cf94301dc7"
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
