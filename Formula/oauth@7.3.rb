# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Oauth Extension
class OauthAT73 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "ae1512182c2a7d88bde167bc10f239af8e71685219fcf6d57debdc316bf5b0c4"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "09c6124a21ac5d114f7ef9d181b4a1d3f7c3fed0764aa1255abcb67e55b5df83"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3dc20adced6f3e2fd07e5d6eefc7ecd4c809f6e7b0af867c5f278cab1409f22f"
    sha256 cellar: :any_skip_relocation, sonoma:        "a73ad69dfc8e70ddbc30083003319e235ce2e36516c46e443aaf4d8b75d2566f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "530edc39f9b1c031ed36fde7aca252491b42528062b5497c5a8a0170f191c348"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b9d40e8a6ed5fd91bd543087ae53d89b13a18873a61d217661aab2dd28525a4e"
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
