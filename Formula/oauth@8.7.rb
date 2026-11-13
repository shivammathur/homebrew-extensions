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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "cd4821c95eb464a7212fb1d225c2639b37828555253f5e5d0aaa860760c359d3"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "8c476ddc79b2bc83752cabb0f44554345c76c3d0adf12a2e3537e42450b29aa3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "edd80c486026f238de41e41bf70db5b0903f402ddae7769c83cf9c82dfcc8078"
    sha256 cellar: :any,                 arm64_linux:       "ca7d2d712c16923f39ac26eb09164287c356f524918a2582bc135b261fa577bc"
    sha256 cellar: :any,                 x86_64_linux:      "537823dccd98a9d896e03cf3ec81ffdec7a11cb0655e1db7f7353483f9009ef1"
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
