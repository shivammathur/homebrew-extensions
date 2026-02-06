# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Oauth Extension
class OauthAT71 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "2c615e439d3fb20a8942d84015a3dc4da963a07581b75de2859be26d1e649e50"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "375c15e1ee66f475e1e423326c9a6ea112e35a3f388cf05a686d32abef983c6b"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "93c9334e8c70429a3590f336994ea37c6942c0cc040f0b3145f57fe967352329"
    sha256 cellar: :any_skip_relocation, sonoma:        "692d7ce9d58d0ed670b998ac5dace2de959f6262b7dba02744f59ef22987aece"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "72b8eb11e23a6fe66fc5d5b10d54a115787d5efb3694983be1ebefa571d8de02"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8f4ab94d00d38985ed9fb24ad2c81c018ceadf237814afb7cbc852739d2868bd"
  end

  depends_on "curl"

  def install
    Dir.chdir "oauth-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-oauth"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
