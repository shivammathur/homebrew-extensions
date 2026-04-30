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
  revision 1
  head "https://github.com/php/pecl-web_services-oauth.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/oauth/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "f4fd86e139a4801a9224b2f94778d0455c3933cc19e37e2e21363a9a921aa965"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "539787aa7c16bb952c71f8c8558d55155c91c06d3e2fb4556cf86b3d7937c4a7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "9cdfb1e0ff5651604a9dfbf95037d4766b3f66d75f9e1399381b5a20dfb16c0f"
    sha256 cellar: :any_skip_relocation, sonoma:        "067a17e3740826fcd81f9681fd5a5fc13d3bbc0ecaa6eca7b521ac11cf6b747b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "44b4dd5c58698dce3f685f4a0c6552b0e84799fde8b57c805a4b0c536adb1b7e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a8fdcbb83aac7ab98732021a6058327655838f5745ad0c9fb2bf87e5b466f7c4"
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
