# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Oauth Extension
class OauthAT87 < AbstractPhpExtension
  init
  desc "Oauth PHP extension"
  homepage "https://github.com/php/pecl-web_services-oauth"
  url "https://pecl.php.net/get/oauth-2.0.10.tgz"
  sha256 "1fd5e074dacf5149603493c454b476d69850bec0a71d7ea69a36a00db728a0fb"
  head "https://github.com/php/pecl-web_services-oauth.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/oauth/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "64542a61befef11c0fa54f3de6e89b74c19ac00827725d60ae06118bc02504df"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "7daf20d31662caaa59e7355a8ce2190b6b0958970ffe3ca5d5fe67305d0c4d95"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "826074832bb7bf002e35f6e6df0925607fee60f5ce3e44dc52ebb43926523e4b"
    sha256 cellar: :any,                 arm64_linux:       "8f71c45ba658584fc756b97368d4fd82366e9b2bc694168fd49dbdb97270d93f"
    sha256 cellar: :any,                 x86_64_linux:      "4913175316733c1d20860e934ae56c0eeca99f42b138a95572c4fd239553b1ca"
  end

  depends_on "curl"

  def install
    Dir.chdir "oauth-#{version}"
    inreplace %w[
      oauth.c
      php_oauth.h
      provider.c
      provider.h
    ], "XtOffsetOf", "offsetof"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-oauth"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
