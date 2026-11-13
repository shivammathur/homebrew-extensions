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
  revision 2
  head "https://github.com/php/pecl-web_services-oauth.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/oauth/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "6c806ab1133993ab58b837ee36bbf8c6a626b048a80d1985c26f41d2371bd51b"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "fe75d355d171597f54168c901a62f48d55a003dfae61d6512e0a3e6ed485df92"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "5fc680809daa396f0a13016fb4662b201725f23a368f4a354e382b3d81fdfccc"
    sha256 cellar: :any,                 arm64_linux:       "3bd76e9bbf99bc9856c7d44151d3bff4340caf4cd255e2e29e8bb85edc6506e2"
    sha256 cellar: :any,                 x86_64_linux:      "faed0b9c39b1737e63f8b64dfdf1f3e80f10da85ec0be4ccb13b052b73dc1d31"
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
