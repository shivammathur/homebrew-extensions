# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT86 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.80.0.tgz"
  sha256 "75e553f2b5c3f7dde99aa984a9601dce6db240bc3c85d7fe09298b5bd8c5d53f"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "2149a91162501280598a384767a7537e60dbc4d5768eb6464a17c34ac82e85f2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "84635563911cee7c0d381c4c9ca4afb0ae4e3abe9a8113627403b010d12eeb41"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "90914fb02a2b6d2ce91d19123a3f0b0b3cffb324158bb00babf1bccf0da21cf9"
    sha256 cellar: :any_skip_relocation, sonoma:        "ce643b72dbcc5ed184fb2438e08a40747b723ca250a99a883dd00cccde21cc6d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a809daa00ac9683672d45dfac06b72c0b419bd29803cb70e2b018215cd07695d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0887a860aa271bfb5ee9fb1b994c47f554efc9804f7b0ee806e74af08b4027cf"
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
