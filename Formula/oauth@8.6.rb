# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Oauth Extension
class OauthAT86 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "097b3d1841b7f9f1031855c76cec9ba4c9f71492f08cf601bef78f4f4fbff2b5"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "5db86cbe3eeaf1c237f84d8eef3f921db571374cd529cba5692912507d3e37b2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "26e41335b6e28e4e6509eb13f270753a66026990b1a7326126bba82c5623985e"
    sha256 cellar: :any,                 arm64_linux:       "b75a3b025cd9c142ddb09c213b694d0e000c44849af4c1f19e9a6400cd11f9be"
    sha256 cellar: :any,                 x86_64_linux:      "2b67aa36d39fc7caa701677d94e66424340b6e31b08ab72ae355a750d4c8a1b5"
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
