# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Oauth Extension
class OauthAT84 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "cb3c4191960d546300e1929d8ff686da6e93fd563deb0285e631a854211cc400"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d92a960f07a9a7c4cfe1465f730b0af9e0cc86f87ea0acd8302c0ceab8e8ed97"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3e9764b99ef43f8d381850adfdf69797ce8958487743b7de57fe7ae1fa69df29"
    sha256 cellar: :any_skip_relocation, sonoma:        "e09591e4bc9b7a55ed9756b67e86c1883c67c36c3e0f6ab66fdcf981c4ede744"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "298740a197f1ca717a1a6bae3019635896d95b14595c80ef29ff8878a534100f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6d20e35acd7b443d42bcef5c3dc0759352e2d9e5ed4e6bf661f509c2bd6eb4da"
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
